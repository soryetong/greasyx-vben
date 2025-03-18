package models

import (
	"time"

	"gorm.io/gorm"
)

type GnModel struct {
	Id        int64          `gorm:"primary" json:"id"`
	CreatedAt time.Time      `json:"createdAt" gorm:"created_at"`
	UpdatedAt time.Time      `json:"-"`
	DeletedAt gorm.DeletedAt `json:"-"`
}
