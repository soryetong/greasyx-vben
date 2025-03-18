package handler

import (
	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/libs/xerror"
	"greasyx-api/admin/internal/logic"
	"greasyx-api/admin/internal/types"
)

func SystemAuthLogin(ctx *gin.Context) {
	var req types.LoginReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	resp, err := logic.NewSystemAuthLogic().Login(ctx, &req)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemAuthLogout(ctx *gin.Context) {
	var req types.LogoutReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemAuthLogic().Logout(ctx, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}
