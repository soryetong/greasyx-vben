package router

import (
	"greasyx-api/admin/internal/handler"
	middleware2 "greasyx-api/admin/internal/middleware"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/libs/middleware"
)

func InitSystemUserRouter(routerGroup *gin.RouterGroup) {
	systemUserGroup := routerGroup.Group("/user")
	systemUserGroup.Use(middleware.Jwt())
	systemUserGroup.Use(middleware.Casbin())
	systemUserGroup.Use(middleware2.Record())
	{
		systemUserGroup.GET("/info", handler.SystemUserInfo)
		systemUserGroup.POST("/add", handler.SystemUserAdd)
		systemUserGroup.GET("/list", handler.SystemUserList)
		systemUserGroup.PUT("/update/:id", handler.SystemUserUpdate)
		systemUserGroup.DELETE("/delete/:id", handler.SystemUserDelete)
	}
}
