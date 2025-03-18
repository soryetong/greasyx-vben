package handler

import (
	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/helper"
	"github.com/soryetong/greasyx/libs/xerror"
	"greasyx-api/admin/internal/logic"
	"greasyx-api/admin/internal/types"
)

func SystemApiAdd(ctx *gin.Context) {
	var req types.UpsertApiReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemApiLogic().Add(ctx, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemApiList(ctx *gin.Context) {
	var req types.ApiListReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	resp, err := logic.NewSystemApiLogic().List(ctx, &req)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemApiUpdate(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	var req types.UpsertApiReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemApiLogic().Update(ctx, id, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemApiDelete(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	if err := logic.NewSystemApiLogic().Delete(ctx, id); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}
