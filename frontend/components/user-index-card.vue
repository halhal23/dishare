<template>
  <el-card>
      <div class="nameplate">
        <nuxt-link :to="{ path: `/users/${user.id}`}" style="width: 40px;">
          <el-avatar :src="user.image.url" :size="40"></el-avatar>
        </nuxt-link>
        <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">
          <nuxt-link :to="{ path: `/users/${user.id}`}" class="dropdown_follow_user">
            {{ user.name }}
          </nuxt-link>
        </p>
        <p style="font-size: 12px; color: #aaa;margin-left: auto;">since: {{ user.created_at.substr(0, 10) }}</p>
      </div>
      <div class="actions">
        <el-dropdown trigger="click">
          <el-badge :value="user.followings.length" class="item" type="warning">
            <el-button size="small">
              Followings <i class="el-icon-arrow-down el-icon--right"></i>
            </el-button>
          </el-badge>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item v-for="f in user.followings" :key="f.id" style="width: 220px;">
              <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                {{ f.name }}
              </nuxt-link>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
        
        <el-dropdown trigger="click" style="margin: 0 20px;">
          <el-badge :value="user.followers.length" class="item" type="warning">
            <el-button size="small">
              Followers <i class="el-icon-arrow-down el-icon--right"></i>
            </el-button>
          </el-badge>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item v-for="f in user.followers" :key="f.id" style="width: 220px;">
              <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                {{ f.name }}
              </nuxt-link>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>

    
        <el-badge :value="user.posts.length" class="item" type="warning">
          <nuxt-link :to="{ path: `/users/${user.id}`}">
            <el-button size="small">
                Posts
            </el-button>
          </nuxt-link>
        </el-badge>
      </div>
  </el-card>
</template>

<script>
export default {
  props: {
    user: Object
  }
}
</script>