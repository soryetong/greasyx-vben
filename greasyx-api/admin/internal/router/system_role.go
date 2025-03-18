package router

import (
	"greasyx-api/admin/internal/handler"
	middleware2 "greasyx-api/admin/internal/middleware"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/libs/middleware"
)

func InitSystemRoleRouter(routerGroup *gin.RouterGroup) {
	systemRoleGroup := routerGroup.Group("/role")
	systemRoleGroup.Use(middleware.Jwt())
	systemRoleGroup.Use(middleware.Casbin())
	systemRoleGroup.Use(middleware2.Record())
	{
		systemRoleGroup.POST("/add", handler.SystemRoleAdd)
		systemRoleGroup.GET("/list", handler.SystemRoleList)
		systemRoleGroup.GET("/info/:id", handler.SystemRoleInfo)
		systemRoleGroup.PUT("/update/:id", handler.SystemRoleUpdate)
		systemRoleGroup.PUT("/assign/:id", handler.SystemRoleAssign)
		systemRoleGroup.DELETE("/delete/:id", handler.SystemRoleDelete)
	}
}
