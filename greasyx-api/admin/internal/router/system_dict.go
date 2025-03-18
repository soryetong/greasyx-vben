package router

import (
	"greasyx-api/admin/internal/handler"
	middleware2 "greasyx-api/admin/internal/middleware"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/libs/middleware"
)

func InitSystemDictRouter(routerGroup *gin.RouterGroup) {
	systemDictGroup := routerGroup.Group("/dict")
	systemDictGroup.Use(middleware.Jwt())
	systemDictGroup.Use(middleware.Casbin())
	systemDictGroup.Use(middleware2.Record())
	{
		systemDictGroup.POST("/add", handler.SystemDictAdd)
		systemDictGroup.GET("/list", handler.SystemDictList)
		systemDictGroup.PUT("/update/:id", handler.SystemDictUpdate)
		systemDictGroup.DELETE("/delete/:id", handler.SystemDictDelete)
	}
}
