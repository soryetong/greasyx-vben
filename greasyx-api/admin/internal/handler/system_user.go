package handler

import (
	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/helper"
	"github.com/soryetong/greasyx/libs/xerror"
	"greasyx-api/admin/internal/logic"
	"greasyx-api/admin/internal/types"
)

func SystemUserInfo(ctx *gin.Context) {
	resp, err := logic.NewSystemUserLogic().Info(ctx)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemUserAdd(ctx *gin.Context) {
	var req types.UpsertUserReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemUserLogic().Add(ctx, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemUserList(ctx *gin.Context) {
	var req types.UserListReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	resp, err := logic.NewSystemUserLogic().List(ctx, &req)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemUserUpdate(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	var req types.UpsertUserReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemUserLogic().Update(ctx, id, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemUserDelete(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	if err := logic.NewSystemUserLogic().Delete(ctx, id); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}
