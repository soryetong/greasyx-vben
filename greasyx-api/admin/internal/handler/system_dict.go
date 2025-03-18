package handler

import (
	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/helper"
	"github.com/soryetong/greasyx/libs/xerror"
	"greasyx-api/admin/internal/logic"
	"greasyx-api/admin/internal/types"
)

func SystemDictAdd(ctx *gin.Context) {
	var req types.UpsertDictReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemDictLogic().Add(ctx, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemDictList(ctx *gin.Context) {
	var req types.DictListReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	resp, err := logic.NewSystemDictLogic().List(ctx, &req)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemDictUpdate(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	var req types.UpsertDictReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemDictLogic().Update(ctx, id, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemDictDelete(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	if err := logic.NewSystemDictLogic().Delete(ctx, id); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}
