package router

import (
	"github.com/gin-gonic/gin"
	"greasyx-api/admin/internal/handler"
)

func InitSystemRecordRouter(routerGroup *gin.RouterGroup) {
	systemRecordGroup := routerGroup.Group("/record")
	{
		systemRecordGroup.GET("/list", handler.SystemRecordList)
		systemRecordGroup.DELETE("/delete/:id", handler.SystemRecordDelete)
	}
}
