<template>
  <el-main class="user_show_wrapper">
        <el-card class="user_info_card">
            <el-row>
              <el-col :span="9" :xs="24" class="card_col left">
                <el-image
                  v-if="user.image.url"
                  style="width: 140px; height: 160px;border-radius: 20px;"
                  :src="user.image.url"
                  fit="fill"></el-image>
                <el-image
                  v-else
                  style="width: 140px; height: 160px;border-radius: 20px;"
                  src="../../images/noimage.png"
                  fit="fill"></el-image>
                <h2 style="margin: 20px 0;color: #fff;font-size: 27px;font-family: 'Josefin Sans';">{{ user.name }}</h2>  
                <template v-if="!isMe">
                  <el-switch
                    v-model="isFollewed"
                    :width="50"
                    @change="changeSwitch(isFollewed)"
                    active-color="#13ce66">
                  </el-switch>
                  <p style="color: #fff;margin: 5px;" v-if="isFollewed">You are following</p>
                  <p style="color: #fff;margin: 5px;" v-else>Not following</p>
                </template>
                <template v-else>
                <el-button 
                    style="float: right; padding: 3px 0;font-size: 22px;color: #fff;margin: 0 auto;width: 100%;" 
                    type="text" 
                    @click="onModal(true)"
                  ><i class="el-icon-edit"></i> EDIT</el-button>
                </template>
              </el-col>
              <el-col :span="15" :xs="24" class="card_col right">
                <h2 class="title">INFOMATION</h2>
                <div class="follow">
                  <div class="follows">
                    <span style="font-family: 'arial black';font-size: 24px;border-bottom: 1px solid #ccc;">Following</span>
                    <!-- <p><span style="font-weight: bold;font-size: 22px;">{{ user.followings.length }}</span> users</p> -->
                    <br>
                    <el-dropdown trigger="click">
                      <p style="cursor: pointer;"><span style="font-weight: bold;font-size: 22px;">{{ user.followings.length }}</span> users</p>
                      <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item v-for="f in user.followings" :key="f.id" style="width: 220px;">
                          <nuxt-link :to="{ path: `/users/${f.id}`}" class="dropdown_follow_user">
                            <el-avatar :src="f.image.url" :size="30" style="margin-right: 30px;"></el-avatar>
                            {{ f.name }}
                          </nuxt-link>
                        </el-dropdown-item>
                      </el-dropdown-menu>
                    </el-dropdown>

                  </div>
                  <div class="follows">
                    <span style="font-family: 'arial black';font-size: 24px;border-bottom: 1px solid #ccc;">Follower</span>
                    <br>
                    <el-dropdown trigger="click">
                      <p style="cursor: pointer;"><span style="font-weight: bold;font-size: 22px;">{{ user.followers.length }}</span> users</p>
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
                <div class="follow">
                  <div class="follows">
                    <span style="font-family: 'arial black';font-size: 24px;border-bottom: 1px solid #ccc;">Posts</span>
                    <p><span style="font-weight: bold;font-size: 22px;">{{ user.posts.length }}</span> posts</p>
                  </div>
                  <div class="follows">
                    <span style="font-family: 'arial black';font-size: 24px;border-bottom: 1px solid #ccc;">Since</span>
                    <p><span style="font-weight: bold;font-size: 18px;color: #aaa;">{{ user.created_at.substr(0, 10) }}</span></p>
                  </div>
                </div>
              </el-col>
            </el-row>
        </el-card>
        <div class="user_posts">
          <p class="title" style="text-align: center;padding: 20px; margin: 5px 40px;font-size: 30px;">POSTS</p>
          <p v-if="user.posts.length == 0" style="text-align: center; margin: 30px; font-weight: bold;">No posts.</p>
          <div class="posts" id="posts">
            <el-timeline>
              <el-timeline-item :timestamp="sliceCreatedAt(p.created_at)" placement="top" v-for="p in user.posts" :key="p.id">
                <postCard :post="p" @getUpdatePosts="getUpdatePosts" />
              </el-timeline-item>
            </el-timeline>
          </div>
        </div>
        <userEditForm :userEditFormModal="userEditFormModal" :currentUser="user" @onModal="onModal(false)" />
  </el-main>
</template>

<script>
import userEditForm from '~/components/modals/user-edit-form.vue'
import postCard from '~/components/post-card.vue'
import { mapState } from 'vuex'
export default {
  async fetch({ params, $axios, store }){
      let baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
      let data = await $axios.$get(baseUrl + `/api/users/${params.id}`)
      store.commit('setUser', data )
  },
  data(){
    return {
      isFollewed: false,
      userEditFormModal: false
    }
  },
  computed: {
    isMe(){
      return this.$store.state.auth.currentUser.id == this.$store.state.user.id ? true : false
    },
    ...mapState({
      user: state => state.user
    })
  },
  async mounted(){
    let res = await this.$axios.$get(process.env.browserBaseUrl + '/api/isFollowed', {
      params: {
        user_id: this.$store.state.auth.currentUser.id,
        follow_id: this.$store.state.user.id
    }})
    this.isFollewed = Boolean(res)
  },
  methods: {
    follow(){
      this.$axios.$post(process.env.browserBaseUrl + '/api/relationships', {
          user_id: this.$store.state.auth.currentUser.id,
          follow_id: this.$store.state.user.id
      }).then(res => {
        this.$store.commit('setUser', res )
        console.log('follow 成功')
        this.$notify({
          title: 'Successfully followed',
          message: `You followed ${res.name}.`,
          type: 'success',
        });
      }).catch(err => {
        this.$notify.error({
          title: 'Error',
          message: `Could not follow.`
        });
      })
    },
    unFollow(){
      this.$axios.$delete(process.env.browserBaseUrl + '/api/relationships/delete', {
        params: {
          user_id: this.$store.state.auth.currentUser.id,
          follow_id: this.$store.state.user.id
        }
      }).then(res => {
        this.$store.commit('setUser', res )
        this.$notify({
          title: 'Successfully unfollowed',
          message: `You unfollowed ${res.name}.`,
          type: 'success',
        });
      }).catch(err => {
        this.$notify.error({
          title: 'Error',
          message: `Could not follow.`
        });
      })
    },
    changeSwitch(bool){
      if(bool){
        this.follow()
      }else {
        this.unFollow()
      }
    },
    async getUpdatePosts(){
          const allPosts = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts')
          this.allPosts = allPosts
    },
    onModal(bool){
      this.userEditFormModal = bool
    },
    sliceCreatedAt(str){
      return str.substr(0, 10) + "  " + str.substr(11, 8)
    },
  },
  components: {
    userEditForm, postCard
  }
}
</script>

<style>
.user_show_wrapper {
  min-height: 100vh;
  padding: 70px 15px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.user_info_card {
  padding: 0;
  width: 600px;
  border-radius: 20px;
}
.user_info_card .el-card__body {
  padding: 0;
  width: 600px;
  border-radius: 20px;
}
.user_info_card .card_col {
  padding: 30px;
  height: 500px;
}
.user_info_card .left {
  /* background: linear-gradient(to right,#87ac01,#bedf01); */
  background: linear-gradient(to right,#d4a300,#ffdc68);
  text-align: center;
}
.user_info_card .title,
.user_posts .title{
  margin-bottom: 15px;
  padding-bottom: 5px;
  border-bottom: 1px solid #e0e0e0;
  color: #353c4e;
  font-family: 'arial black';
  letter-spacing: 5px;
}
.user_info_card .follow {
  background: #fff;
  display: flex;
  justify-content: space-between;
  margin: 50px 0;
}
.user_info_card .follows {
  background: #fff;
}
.user_show_wrapper .user_posts {
  background: #fccd87;
  border-radius: 20px;
  width: 600px;
  height: 600px;
  margin-top: 30px;
  box-shadow: 0 0 8px #ccc;
}
.user_show_wrapper .user_posts .posts{
  height: 480px;
  width: 100%;
  overflow-y: scroll;
  padding: 30px 5px;
}
.user_show_wrapper .user_posts .posts ul{
  padding: 0;
}
@media (min-width: 0px) and (max-width: 768px) {
  .user_info_card,
  .user_show_wrapper .user_posts,
  .user_info_card .el-card__body {
    width: 100%;
  }
  .user_info_card .card_col {
    height: 330px;
  }
}
</style>