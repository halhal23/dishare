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
                <p><span style="font-weight: bold;font-size: 22px;">{{ user.followings.length }}</span> users</p>
              </div>
              <div class="follows">
                <span style="font-family: 'arial black';font-size: 24px;border-bottom: 1px solid #ccc;">Follower</span>
                <p><span style="font-weight: bold;font-size: 22px;">{{ user.followers.length }}</span> users</p>
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
        <!-- <p v-for="u in user.followings" :key="u.name">{{ u.name }}</p>
        <h2>followers</h2>
        <p v-for="u in user.followers" :key="u.id">{{ u.name }}</p>
        <h2 @click="unFollow">unfollow</h2> -->
        <userEditForm :userEditFormModal="userEditFormModal" :currentUser="user" @onModal="onModal(false)" />
    </el-card>
  </el-main>
</template>

<script>
import userEditForm from '~/components/modals/user-edit-form.vue'
import { mapState } from 'vuex'
export default {
  // async asyncData({ params, $axios }){
  //     console.log('async users_id')
  //     let baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
  //     let data = await $axios.$get(baseUrl + `/api/users/${params.id}`)
  //     console.log(data)
  //     return {
  //       user: data
  //     }
  // },
  async fetch({ params, $axios, store }){
      console.log('fetch users_id')
      let baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
      let data = await $axios.$get(baseUrl + `/api/users/${params.id}`)
      console.log(data)
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
        this.user = res
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
        this.user = res
        console.log('unFollow 成功')
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
    onModal(bool){
      this.userEditFormModal = bool
    }
  },
  components: {
    userEditForm
  }
}
</script>

<style>
.user_show_wrapper {
  min-height: 100vh;
  padding: 70px 15px;
  display: flex;
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
.user_info_card .title {
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
@media (min-width: 0px) and (max-width: 768px) {
  .user_info_card .card ,
  .user_info_card .el-card__body {
    width: 100%;
  }
  .user_info_card .card_col {
    height: 330px;
  }
}
</style>