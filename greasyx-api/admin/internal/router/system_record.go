package router

import (
	"greasyx-api/admin/internal/handler"
	middleware2 "greasyx-api/admin/internal/middleware"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/libs/middleware"
)

func InitSystemRecordRouter(routerGroup *gin.RouterGroup) {
	systemRecordGroup := routerGroup.Group("/record")
	systemRecordGroup.Use(middleware.Jwt())
	systemRecordGroup.Use(middleware.Casbin())
	systemRecordGroup.Use(middleware2.Record())
	{
		systemRecordGroup.GET("/list", handler.SystemRecordList)
		systemRecordGroup.DELETE("/delete/:id", handler.SystemRecordDelete)
	}
}
