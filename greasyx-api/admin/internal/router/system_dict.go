package router

import (
	"github.com/gin-gonic/gin"
	"greasyx-api/admin/internal/handler"
)

func InitSystemDictRouter(routerGroup *gin.RouterGroup) {
	systemDictGroup := routerGroup.Group("/dict")
	{
		systemDictGroup.POST("/add", handler.SystemDictAdd)
		systemDictGroup.GET("/list", handler.SystemDictList)
		systemDictGroup.PUT("/update/:id", handler.SystemDictUpdate)
		systemDictGroup.DELETE("/delete/:id", handler.SystemDictDelete)
	}
}
