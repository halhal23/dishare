<template>
  <el-main class="users_index_wrapper">
    <!-- <el-menu
      default-active="1"
      class="el-menu-demo"
      mode="horizontal"
      @select="handleSelectUsers"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b">
      <el-menu-item index="1">Followings</el-menu-item>
      <el-menu-item index="2">Followers</el-menu-item>
      <el-menu-item index="3">All users</el-menu-item>
    </el-menu> -->
    <el-tabs v-model="tabActive" @tab-click="handleSelectUsers">
      <el-tab-pane label="Followings" name="first">

        <div class="users">
          <el-card v-for="u in followings" :key="u.id">
              <div class="nameplate">
                <nuxt-link :to="{ path: `/users/${u.id}`}" style="width: 40px;">
                  <el-avatar :src="u.image.url" :size="40"></el-avatar>
                </nuxt-link>
                <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">
                  <nuxt-link :to="{ path: `/users/${u.id}`}" class="dropdown_follow_user">
                    {{ u.name }}
                  </nuxt-link>
                </p>
                <p style="font-size: 12px; color: #aaa;margin-left: auto;">since: {{ u.created_at.substr(0, 10) }}</p>
              </div>
              <div class="actions">
                <el-dropdown trigger="click">
                  <el-badge :value="u.followings.length" class="item" type="warning">
                    <el-button size="small">
                      Followings <i class="el-icon-arrow-down el-icon--right"></i>
                    </el-button>
                  </el-badge>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item v-for="f in u.followings" :key="f.id" style="width: 220px;">
                      <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                        <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                        {{ f.name }}
                      </nuxt-link>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>
                
                <el-dropdown trigger="click" style="margin: 0 20px;">
                  <el-badge :value="u.followers.length" class="item" type="warning">
                    <el-button size="small">
                      Followers <i class="el-icon-arrow-down el-icon--right"></i>
                    </el-button>
                  </el-badge>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item v-for="f in u.followers" :key="f.id" style="width: 220px;">
                      <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                        <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                        {{ f.name }}
                      </nuxt-link>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>

            
                <el-badge :value="u.posts.length" class="item" type="warning">
                  <nuxt-link :to="{ path: `/users/${u.id}`}">
                    <el-button size="small">
                        Posts
                    </el-button>
                  </nuxt-link>
                </el-badge>
              </div>
          </el-card>
        </div>

      </el-tab-pane>
      <el-tab-pane label="Followers" name="second">


        <div class="users">
          <el-card v-for="u in followers" :key="u.id">
              <div class="nameplate">
                <nuxt-link :to="{ path: `/users/${u.id}`}" style="width: 40px;">
                  <el-avatar :src="u.image.url" :size="40"></el-avatar>
                </nuxt-link>
                <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">
                  <nuxt-link :to="{ path: `/users/${u.id}`}" class="dropdown_follow_user">
                    {{ u.name }}
                  </nuxt-link>
                </p>
                <p style="font-size: 12px; color: #aaa;margin-left: auto;">since: {{ u.created_at.substr(0, 10) }}</p>
              </div>
              <div class="actions">
                <el-dropdown trigger="click">
                  <el-badge :value="u.followings.length" class="item" type="warning">
                    <el-button size="small">
                      Followings <i class="el-icon-arrow-down el-icon--right"></i>
                    </el-button>
                  </el-badge>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item v-for="f in u.followings" :key="f.id" style="width: 220px;">
                      <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                        <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                        {{ f.name }}
                      </nuxt-link>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>
                
                <el-dropdown trigger="click" style="margin: 0 20px;">
                  <el-badge :value="u.followers.length" class="item" type="warning">
                    <el-button size="small">
                      Followers <i class="el-icon-arrow-down el-icon--right"></i>
                    </el-button>
                  </el-badge>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item v-for="f in u.followers" :key="f.id" style="width: 220px;">
                      <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                        <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                        {{ f.name }}
                      </nuxt-link>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>

            
                <el-badge :value="u.posts.length" class="item" type="warning">
                  <nuxt-link :to="{ path: `/users/${u.id}`}">
                    <el-button size="small">
                        Posts
                    </el-button>
                  </nuxt-link>
                </el-badge>
              </div>
          </el-card>
        </div>

      </el-tab-pane>
      <el-tab-pane label="All users" name="third">

        <div class="users">
          <el-card v-show="allUsers.length != 0" v-for="u in allUsers" :key="u.id">
              <div class="nameplate">
                <nuxt-link :to="{ path: `/users/${u.id}`}" style="width: 40px;">
                  <el-avatar :src="u.image.url" :size="40"></el-avatar>
                </nuxt-link>
                <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">
                  <nuxt-link :to="{ path: `/users/${u.id}`}" class="dropdown_follow_user">
                    {{ u.name }}
                  </nuxt-link>
                </p>
                <p style="font-size: 12px; color: #aaa;margin-left: auto;">since: {{ u.created_at.substr(0, 10) }}</p>
              </div>
              <div class="actions">
                <el-dropdown trigger="click">
                  <el-badge :value="u.followings.length" class="item" type="warning">
                    <el-button size="small">
                      Followings <i class="el-icon-arrow-down el-icon--right"></i>
                    </el-button>
                  </el-badge>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item v-for="f in u.followings" :key="f.id" style="width: 220px;">
                      <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                        <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                        {{ f.name }}
                      </nuxt-link>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>
                
                <el-dropdown trigger="click" style="margin: 0 20px;">
                  <el-badge :value="u.followers.length" class="item" type="warning">
                    <el-button size="small">
                      Followers <i class="el-icon-arrow-down el-icon--right"></i>
                    </el-button>
                  </el-badge>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item v-for="f in u.followers" :key="f.id" style="width: 220px;">
                      <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                        <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                        {{ f.name }}
                      </nuxt-link>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>

            
                <el-badge :value="u.posts.length" class="item" type="warning">
                  <nuxt-link :to="{ path: `/users/${u.id}`}">
                    <el-button size="small">
                        Posts
                    </el-button>
                  </nuxt-link>
                </el-badge>
              </div>
          </el-card>
        </div>


      </el-tab-pane>
    </el-tabs>

  </el-main>
</template>
</template>

<script>
export default {
  async asyncData({ $axios, store }){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const user = await $axios.$get(baseUrl + `/api/users/${store.state.auth.currentUser.id}`)
    return {
      followings: user.followings,
      followers: user.followers,
      allUsers: [],
      tabActive: 'first'
    }
  },
  methods: {
    async handleSelectUsers(tab){
      console.log(tab.label)
      switch (tab.label){
        case 'All users':
          const allUsersData = await this.$axios.$get(process.env.browserBaseUrl + '/api/users')
          this.allUsers = allUsersData
          break   
      }
    },
    async handleTabClick(tab){
      console.log(tab.label)
      switch (tab.label){
        case 'Followings':
          const followingsData = await this.$axios.$get(process.env.browserBaseUrl + '/api/users/followings', {
            params: { id: this.$store.state.auth.currentUser.id }
          })
          this.users = followingsData
          break   
        case 'Followers':
          const followersData = await this.$axios.$get(process.env.browserBaseUrl + '/api/users/followers', {
            params: { id: this.$store.state.auth.currentUser.id }
          })
          this.users = followersData
          break
        case 'All users':
          const allUsersData = await this.$axios.$get(process.env.browserBaseUrl + '/api/users')
          this.users = allUsersData
          break   
      }
    }
  }
}
</script>

<style>
.users_index_wrapper {
  height: 100vh;
  padding: 60px 60px 0;
}
.users_index_wrapper .users {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: flex-start;
  align-content: flex-start;
  height: 90%;
  padding: 30px 0;
  background: #f1decc;
}
.users_index_wrapper .el-card {
  margin-bottom: 20px;
}
.users_index_wrapper .nameplate {
  display: flex;
  align-items: center;
}
.users_index_wrapper .actions {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  margin: 20px 0 0;
}
.users_index_wrapper a {
  padding: 0;
  color: #333;
}
.users_index_wrapper .el-tabs__content {
  background: #f1decc;
  height: 80vh;
}
.users_index_wrapper .el-tabs__header {
  background: #f1decc;
  padding: 20px;
  margin: 0;
}
@media (min-width: 0px) and (max-width: 768px) {
  .users_index_wrapper {
    padding: 70px 0;
  }
}
</style>