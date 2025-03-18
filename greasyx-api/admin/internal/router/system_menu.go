package router

import (
	"greasyx-api/admin/internal/handler"
	middleware2 "greasyx-api/admin/internal/middleware"

	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/libs/middleware"
)

func InitSystemMenuRouter(routerGroup *gin.RouterGroup) {
	systemMenuGroup := routerGroup.Group("/menu")
	systemMenuGroup.Use(middleware.Jwt())
	systemMenuGroup.Use(middleware.Casbin())
	systemMenuGroup.Use(middleware2.Record())
	{
		systemMenuGroup.GET("/router", handler.SystemMenuRouter)
		systemMenuGroup.GET("/tree", handler.SystemMenuTree)
		systemMenuGroup.POST("/add", handler.SystemMenuAdd)
		systemMenuGroup.PUT("/update/:id", handler.SystemMenuUpdate)
		systemMenuGroup.GET("/info/:id", handler.SystemMenuInfo)
		systemMenuGroup.DELETE("/delete/:id", handler.SystemMenuDelete)
	}
}
