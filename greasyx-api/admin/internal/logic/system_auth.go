package logic

import (
	"context"
	"errors"
	"greasyx-api/admin/internal/types"
	"greasyx-api/models"
	"time"

	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/helper"
	"github.com/soryetong/greasyx/libs/xauth"
	"go.uber.org/zap"
)

type SystemAuthLogic struct {
}

func NewSystemAuthLogic() *SystemAuthLogic {
	return &SystemAuthLogic{}
}

func (self *SystemAuthLogic) Login(ctx context.Context, params *types.LoginReq) (resp *types.LoginResp, err error) {
	user := new(models.SysUsers)
	if err = gina.GMySQL().Model(&models.SysUsers{}).Where("username = ?", params.Username).First(user).Error; err != nil {
		return nil, errors.New("用户不存在")
	}
	if user.Status != models.SysUserStatusNormal {
		return nil, errors.New("用户已被禁用")
	}

	if helper.ValidatePasswd(params.Password, user.Salt, user.Password) == false {
		return nil, errors.New("密码错误")
	}

	token, err := xauth.GenerateJwtToken(map[string]interface{}{
		"id":       user.Id,
		"username": user.Username,
		"role_id":  user.RoleId,
		"exp":      time.Now().Add(time.Minute * 20).Unix(),
	})
	if err != nil {
		gina.Log.Error("生成 token 失败", zap.Error(err))
		return nil, errors.New("生成 token 失败")
	}

	resp = &types.LoginResp{
		AccessToken: token,
		Id:          user.Id,
		Password:    "",
		RealName:    user.Username,
		Roles:       []string{""},
		Username:    user.Username,
	}

	return
}

func (self *SystemAuthLogic) Logout(ctx context.Context, params *types.LogoutReq) (err error) {
	// TODO implement

	return nil
}

func (self *SystemAuthLogic) Codes(ctx context.Context) (resp []string, err error) {
	resp = []string{
		"AC_100100",
		"AC_100110",
		"AC_100120",
		"AC_100010",
	}

	return
}
