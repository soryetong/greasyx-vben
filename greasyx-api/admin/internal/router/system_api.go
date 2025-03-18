package router

import (
	"greasyx-api/admin/internal/handler"
	middleware2 "greasyx-api/admin/internal/middleware"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/libs/middleware"
)

func InitSystemApiRouter(routerGroup *gin.RouterGroup) {
	systemApiGroup := routerGroup.Group("/api")
	systemApiGroup.Use(middleware.Jwt())
	systemApiGroup.Use(middleware.Casbin())
	systemApiGroup.Use(middleware2.Record())
	{
		systemApiGroup.POST("/add", handler.SystemApiAdd)
		systemApiGroup.GET("/list", handler.SystemApiList)
		systemApiGroup.PUT("/update/:id", handler.SystemApiUpdate)
		systemApiGroup.DELETE("/delete/:id", handler.SystemApiDelete)
	}
}
