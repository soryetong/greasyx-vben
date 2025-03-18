package handler

import (
	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/helper"
	"github.com/soryetong/greasyx/libs/xerror"
	"greasyx-api/admin/internal/logic"
	"greasyx-api/admin/internal/types"
)

func SystemMenuRouter(ctx *gin.Context) {
	resp, err := logic.NewSystemMenuLogic().Router(ctx)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemMenuTree(ctx *gin.Context) {
	var req types.MenuTreeReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	resp, err := logic.NewSystemMenuLogic().Tree(ctx, &req)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemMenuAdd(ctx *gin.Context) {
	var req types.MenuInfo
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemMenuLogic().Add(ctx, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemMenuUpdate(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	var req types.MenuInfo
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemMenuLogic().Update(ctx, id, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemMenuInfo(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	resp, err := logic.NewSystemMenuLogic().Info(ctx, id)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemMenuDelete(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	if err := logic.NewSystemMenuLogic().Delete(ctx, id); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}
