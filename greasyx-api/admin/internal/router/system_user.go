package router

import (
	"github.com/gin-gonic/gin"
	"greasyx-api/admin/internal/handler"
)

func InitSystemUserRouter(routerGroup *gin.RouterGroup) {
	systemUserGroup := routerGroup.Group("/user")
	{
		systemUserGroup.GET("/info", handler.SystemUserInfo)
		systemUserGroup.POST("/add", handler.SystemUserAdd)
		systemUserGroup.GET("/list", handler.SystemUserList)
		systemUserGroup.PUT("/update/:id", handler.SystemUserUpdate)
		systemUserGroup.DELETE("/delete/:id", handler.SystemUserDelete)
	}
}
