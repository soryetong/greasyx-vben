package router

import (
	"github.com/gin-gonic/gin"
	"greasyx-api/admin/internal/handler"
)

func InitSystemMenuRouter(routerGroup *gin.RouterGroup) {
	systemMenuGroup := routerGroup.Group("/menu")
	{
		systemMenuGroup.GET("/router", handler.SystemMenuRouter)
		systemMenuGroup.GET("/tree", handler.SystemMenuTree)
		systemMenuGroup.POST("/add", handler.SystemMenuAdd)
		systemMenuGroup.PUT("/update/:id", handler.SystemMenuUpdate)
		systemMenuGroup.GET("/info/:id", handler.SystemMenuInfo)
		systemMenuGroup.DELETE("/delete/:id", handler.SystemMenuDelete)
	}
}
