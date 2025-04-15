package middleware

import (
	"bytes"
	"encoding/json"
	"fmt"
	"greasyx-api/admin/internal/logic"
	"greasyx-api/models"
	"io"
	"net/url"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/helper"
	"github.com/soryetong/greasyx/libs/xauth"

	"go.uber.org/zap"
)

var notRecord = map[string]struct{}{}

func Record() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		path, id := helper.GetRequestPath(ctx.Request.URL.Path, "/api")
		if _, ok := notRecord[path]; ok || ctx.Request.Method == "GET" {
			ctx.Next()
			return
		}

		body := make(map[string]interface{})
		if id != 0 {
			body["id"] = id
		}

		if ctx.Request.Body != nil {
			bodyPost, _ := io.ReadAll(ctx.Request.Body)
			ctx.Request.Body = io.NopCloser(bytes.NewBuffer(bodyPost))
			body["post"] = string(bodyPost)
		}

		query := ctx.Request.URL.RawQuery
		if query != "" {
			query, _ = url.QueryUnescape(query)
			for _, v := range strings.Split(query, "&") {
				kv := strings.Split(v, "=")
				if len(kv) == 2 {
					body[kv[0]] = kv[1]
				}
			}
		}

		request, _ := json.Marshal(body)
		userAgent := ctx.GetHeader("User-Agent")
		newPath := strings.TrimPrefix(ctx.Request.URL.Path, "/api")
		record := models.SysRecords{
			Method:      ctx.Request.Method,
			Path:        path,
			Request:     string(request),
			UserId:      xauth.GetTokenData[int64](ctx, "id"),
			Username:    xauth.GetTokenData[string](ctx, "username"),
			Platform:    helper.GetPlatform(userAgent) + " " + helper.GetBrowser(userAgent),
			Description: new(logic.SystemApiLogic).GetRecordDescription(helper.ConvertToRestfulURL(newPath), ctx.Request.Method),
			Ip:          helper.GetClientRealIP(ctx),
		}

		writer := &responseBodyWriter{
			ResponseWriter: ctx.Writer,
			body:           &bytes.Buffer{},
		}
		ctx.Writer = writer
		startTime := time.Now()

		ctx.Next()

		elapsedMs := time.Since(startTime).Seconds() * 1000
		record.Elapsed = fmt.Sprintf("%.2f", elapsedMs)
		resp := &gina.Response{}
		_ = json.Unmarshal([]byte(writer.body.String()), resp)
		record.StatusCode = resp.Code
		record.Msg = resp.Msg
		respData, _ := json.Marshal(resp.Data)
		record.Response = string(respData)

		if err := gina.GMySQL().Create(&record).Error; err != nil {
			gina.Log.Error("记录操作日志异常", zap.Error(err), zap.Any("record", record))
		}
	}
}

type responseBodyWriter struct {
	gin.ResponseWriter
	body *bytes.Buffer
}

func (r *responseBodyWriter) Write(b []byte) (int, error) {
	r.body.Write(b)
	return r.ResponseWriter.Write(b)
}

func (r *responseBodyWriter) WriteHeader(statusCode int) {
	if !r.Written() { // 避免重复写入 Header
		r.ResponseWriter.WriteHeader(statusCode)
	}
}
