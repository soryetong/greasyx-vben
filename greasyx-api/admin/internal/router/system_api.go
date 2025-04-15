package router

import (
	"github.com/gin-gonic/gin"
	"greasyx-api/admin/internal/handler"
)

func InitSystemApiRouter(routerGroup *gin.RouterGroup) {
	systemApiGroup := routerGroup.Group("/api")
	{
		systemApiGroup.POST("/add", handler.SystemApiAdd)
		systemApiGroup.GET("/list", handler.SystemApiList)
		systemApiGroup.PUT("/update/:id", handler.SystemApiUpdate)
		systemApiGroup.DELETE("/delete/:id", handler.SystemApiDelete)
	}
}
