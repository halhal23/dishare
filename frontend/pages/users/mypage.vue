<template>
  <el-main class="mypage_wrapper">
    <div class="box">
      <div class="profile">
        <div class="image">
          <el-avatar :src="user.image.url" :size="120"></el-avatar>
          <p class="user_name">
            {{ user.name }}  <i @click="onModal(true)" class="el-icon-edit" style="font-size: 30px;cursor: pointer;"></i>
          </p>
        </div>
        <div class="info">
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
          <br>
          <el-dropdown trigger="click">
            <el-badge style="margin-top: 30px;" :value="user.followers.length" class="item" type="warning">
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
        </div>
      </div>
      <el-row style="width: 100%;" :gutter="10">
        <el-col :md="12">
          <div class="invitations">
            <p class="title">
              The invitation you sent.
            </p>
            <div class="invitations_container">
              <div v-for="invite in user.active_invitations" :key="invite.id" class="invitation_card">
                <el-avatar style="flex-shrink: 0;" :src="invite.invited.image.url" :size="50"></el-avatar>
                <div style="margin: 0 12px; width: 100%;">
                  <p>{{ invite.invited.name }}</p>
                  <el-divider content-position="right">
                    <i v-if="invite.result == 1" style="color: #2d2" class="el-icon-success"></i>
                    <i v-else-if="invite.result == 2" style="color: tomato" class="el-icon-error"></i>
                    <i v-else style="color: #bbb" class="el-icon-remove-outline"></i>
                  </el-divider>
                  <p style="font-size: 12px; color: #999;">on {{ invite.invite_date }}</p>
                </div>
                <nuxt-link :to="{ path: `/invitations/${invite.id}` }" style="padding: 0;width: 40px;height: 40px;">
                  <i class="el-icon-info" style="font-size: 40px;"></i>
                </nuxt-link>
              </div>
              <div v-if="user.active_invitations.length == 0" style="text-align: center;">
                <p style="margin: 20px 0;">No invitations.</p>
                <p style="margin: 20px 0;">Let's invite your followers</p>
                <el-button style="margin: 20px 0;">
                  <nuxt-link style="color: #555;" to="/invitations/new">INVITE</nuxt-link>
                </el-button>
              </div>
            </div>
          </div>
        </el-col>
        <el-col :md="12">
          <div class="invitations">
            <p class="title">
              The invitation you received.
            </p>
            <div class="invitations_container">
              <div v-for="invite in user.passive_invitations" :key="invite.id" class="invitation_card">
                <el-avatar style="flex-shrink: 0;" :src="invite.inviter.image.url" :size="50"></el-avatar>
                <div style="margin: 0 12px; width: 100%;">
                  <p>{{ invite.inviter.name }}</p>
                  <el-divider content-position="right">
                    <i v-if="invite.result == 1" style="color: #2d2" class="el-icon-success"></i>
                    <i v-else-if="invite.result == 2" style="color: tomato" class="el-icon-error"></i>
                    <i v-else style="color: #bbb" class="el-icon-remove-outline"></i>
                  </el-divider>
                  <p style="font-size: 12px; color: #999;">on {{ invite.invite_date }}</p>
                </div>
                <nuxt-link :to="{ path: `/invitations/${invite.id}` }" style="padding: 0;width: 40px;height: 40px;">
                  <i class="el-icon-info" style="font-size: 40px;"></i>
                </nuxt-link>
              </div>
              <div v-if="user.passive_invitations.length == 0" style="text-align: center;">
                <p style="margin: 20px 0;">No invitations received.</p>
              </div>
            </div>
          </div>
        </el-col>
        <el-col :span="24">
          <div class="posts">
            <postCard v-for="p in user.posts" :key="p.id" :post="p" @getUpdatePosts="getUpdatePosts" />
              <div v-if="user.posts.length == 0" style="text-align: center;">
                <p style="margin: 20px 0;">No posts.</p>
                <p style="margin: 20px 0;">Let's make a post about food!</p>
                <el-button style="margin: 20px 0;">
                  <nuxt-link style="color: #555;" to="/posts/new">POST CREATE</nuxt-link>
                </el-button>
              </div>
          </div>
        </el-col>
      </el-row>
    </div>
    <userEditForm :userEditFormModal="userEditFormModal" :currentUser="user" @onModal="onModal(false)" />
  </el-main>
</template>
<script>
import userEditForm from '~/components/modals/user-edit-form.vue'
import postCard from '~/components/post-card.vue'
import { mapState } from 'vuex'
export default {
  async fetch({ $axios, store }){
      let baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
      let data = await $axios.$get(baseUrl + `/api/users/${store.state.auth.currentUser.id}`)
      store.commit('setUser', data )
  },
  data(){
    return {
      userEditFormModal: false
    }
  },
  methods: {
    getUpdatePosts(){
      console.log('update')
    },
    onModal(bool){
      this.userEditFormModal = bool
    }
  },
  computed: {
    ...mapState({
      user: state => state.user
    })
  },
  components: {
    postCard, userEditForm
  }
}
</script>
<style>
.mypage_wrapper {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  padding-left: 30px;
}
.mypage_wrapper .box {
  width: 95%;
  border-radius: 14px;
  padding: 14px;
  display: flex;
  align-items: center;
}
.mypage_wrapper .profile {
  height: 100%;
  width: 240px;
  flex-shrink: 0;
  margin-right: 10px;
  border-radius: 14px;
  box-shadow: 0 0 10px #ccc;
  background: #fff;
}
.mypage_wrapper .profile .image {
  background: linear-gradient(to right,#d4a300,#ffdc68);
  border-top-left-radius: 14px;
  border-top-right-radius: 14px;
  text-align: center;
  padding: 30px 0;
}
.dropdown_follow_user {
  display: flex;
  align-items: center;
  color: #666;
  border-bottom: 1px solid rgba(236, 215, 25, 0.8);
}
.mypage_wrapper .profile .image .user_name{
  font-size: 24px;
  margin-top: 20px;
  font-weight: bold;
  color: #fff;
}
.mypage_wrapper .profile .info{
  text-align: center;
  padding: 30px;
}
.mypage_wrapper .invitations {
  height: 100%;
  box-shadow: 0 0 8px #ccc;
  width: 100%;
  margin-bottom: 40px;
  background: #fff;
}
.invitations_container {
  height: 240px;
  overflow-y: scroll;
}
.invitation_card {
  box-shadow: 0 0 8px #ccc;
  width: 300px;
  height: 60px;
  margin: 20px auto;
  border-radius: 30px;
  display: flex;
  align-items: center;
  padding: 0 10px;
}
.mypage_wrapper .invitations .title{
  text-align: center;
  font-size: 20px;
  font-weight: bold;
  background: rgb(102, 89, 16);
  color: #eee;
}
.mypage_wrapper .el-divider--horizontal{
  margin: 8px 0;
}

.mypage_wrapper .posts {
  height: 100%;
  padding: 30px 0;
  box-shadow: 0 0 8px #ccc;
  width: 100%;
  display: flex;
  align-items: center;
  flex-direction: column;
  height: 400px;
  overflow-y: scroll;
  background: #fff;
}

@media (min-width: 0px) and (max-width: 992px) {
  .mypage_wrapper {
    width: 100%;
    padding-left: 70px;
  }
  .mypage_wrapper .box{
    width: 100%;
  }
}
@media (min-width: 0px) and (max-width: 868px) {
  .mypage_wrapper {
    padding: 70px 0;
  }
  .mypage_wrapper .box{
    width: 100%;
    flex-direction: column;
    align-items: center;
    box-shadow: none;
  }
  .mypage_wrapper .invitations{
    margin-top: 30px;
  }
}
</style>
