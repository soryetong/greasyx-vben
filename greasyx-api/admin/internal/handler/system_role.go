package handler

import (
	"github.com/gin-gonic/gin"
	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/helper"
	"github.com/soryetong/greasyx/libs/xerror"
	"greasyx-api/admin/internal/logic"
	"greasyx-api/admin/internal/types"
)

func SystemRoleAdd(ctx *gin.Context) {
	var req types.UpsertRoleReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemRoleLogic().Add(ctx, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemRoleList(ctx *gin.Context) {
	var req types.RoleListReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	resp, err := logic.NewSystemRoleLogic().List(ctx, &req)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemRoleInfo(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	resp, err := logic.NewSystemRoleLogic().Info(ctx, id)
	if err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, resp)
}

func SystemRoleUpdate(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	var req types.UpsertRoleReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemRoleLogic().Update(ctx, id, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemRoleAssign(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	var req types.AssignRoleReq
	if err := ctx.ShouldBind(&req); err != nil {
		gina.FailWithMessage(ctx, xerror.Trans(err))
		return
	}

	if err := logic.NewSystemRoleLogic().Assign(ctx, id, &req); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}

func SystemRoleDelete(ctx *gin.Context) {
	id := helper.StringToInt64(ctx.Param("id"))
	if helper.IsValidNumber(id) == false {
		gina.FailWithMessage(ctx, "参数错误")
		return
	}
	if err := logic.NewSystemRoleLogic().Delete(ctx, id); err != nil {
		gina.FailWithMessage(ctx, err.Error())
		return
	}

	gina.Success(ctx, nil)
}
