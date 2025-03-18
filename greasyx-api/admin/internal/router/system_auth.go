package router

import (
	"github.com/gin-gonic/gin"
	"greasyx-api/admin/internal/handler"

	middleware2 "greasyx-api/admin/internal/middleware"
)

func InitSystemAuthRouter(routerGroup *gin.RouterGroup) {
	systemAuthGroup := routerGroup.Group("/auth")
	systemAuthGroup.Use(middleware2.Record())
	{
		systemAuthGroup.POST("/login", handler.SystemAuthLogin)
		systemAuthGroup.POST("/logout", handler.SystemAuthLogout)
	}
}
