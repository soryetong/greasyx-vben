package router

import (
	"github.com/gin-gonic/gin"
	"greasyx-api/admin/internal/handler"
)

func InitSystemAuthRouter(routerGroup *gin.RouterGroup) {
	systemAuthGroup := routerGroup.Group("/auth")
	{
		systemAuthGroup.POST("/login", handler.SystemAuthLogin)
		systemAuthGroup.POST("/logout", handler.SystemAuthLogout)
	}
}
