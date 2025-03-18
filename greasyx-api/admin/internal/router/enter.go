package router

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/libs/middleware"
)

func InitRouter() *gin.Engine {
	r := gin.Default()
	fs := "/uploads"
	r.StaticFS(fs, http.Dir("./"+fs))

	r.Use(middleware.Cross())
	groups := r.Group("/api")
	InitSystemAuthRouter(groups)
	InitSystemMenuRouter(groups)
	InitSystemRoleRouter(groups)
	InitSystemUserRouter(groups)
	InitSystemDictRouter(groups)
	InitSystemRecordRouter(groups)
	InitSystemApiRouter(groups)
	return r
}
