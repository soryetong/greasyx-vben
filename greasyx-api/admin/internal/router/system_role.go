package router

import (
	"github.com/gin-gonic/gin"
	"greasyx-api/admin/internal/handler"
)

func InitSystemRoleRouter(routerGroup *gin.RouterGroup) {
	systemRoleGroup := routerGroup.Group("/role")
	{
		systemRoleGroup.POST("/add", handler.SystemRoleAdd)
		systemRoleGroup.GET("/list", handler.SystemRoleList)
		systemRoleGroup.GET("/info/:id", handler.SystemRoleInfo)
		systemRoleGroup.PUT("/update/:id", handler.SystemRoleUpdate)
		systemRoleGroup.PUT("/assign/:id", handler.SystemRoleAssign)
		systemRoleGroup.DELETE("/delete/:id", handler.SystemRoleDelete)
	}
}
