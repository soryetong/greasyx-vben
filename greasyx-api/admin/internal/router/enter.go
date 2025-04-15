package router

import (
	"greasyx-api/admin/internal/middleware"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/libs/xmiddleware"
	"github.com/spf13/viper"
)

func InitRouter() *gin.Engine {
	setMode()

	r := gin.Default()
	fs := "/uploads"
	r.StaticFS(fs, http.Dir("./"+fs))

	r.Use(xmiddleware.Begin()).Use(xmiddleware.Cross()).Use(middleware.Record())
	publicGroup := r.Group("/api")
	{
		// 健康监测
		publicGroup.GET("/health", func(c *gin.Context) {
			c.JSON(200, "ok")
		})

		InitSystemAuthRouter(publicGroup)
	}

	privateAuthGroup := r.Group("/api")
	privateAuthGroup.Use(xmiddleware.Casbin()).Use(xmiddleware.Jwt())
	{
		InitSystemApiRouter(privateAuthGroup)
		InitSystemDictRouter(privateAuthGroup)
		InitSystemMenuRouter(privateAuthGroup)
		InitSystemRecordRouter(privateAuthGroup)
		InitSystemRoleRouter(privateAuthGroup)
		InitSystemUserRouter(privateAuthGroup)
	}

	return r
}

func setMode() {
	switch viper.GetString("App.Env") {
	case gin.DebugMode:
		gin.SetMode(gin.DebugMode)
	case gin.ReleaseMode:
		gin.SetMode(gin.ReleaseMode)
	default:
		gin.SetMode(gin.TestMode)
	}
}
