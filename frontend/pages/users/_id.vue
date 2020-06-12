<template>
  <el-main class="user_show_wrapper">
   <el-card class="card">
      <el-row>
        <el-col :span="9" :xs="24" class="card_col left">
          <el-image
            style="width: 140px; height: 160px;border-radius: 20px;"
            :src="user.image.url"
            fit="fill"></el-image>
          <h2 style="margin: 20px 0;color: #fff;font-size: 27px;font-family: 'Josefin Sans';">{{ user.name }}</h2>  
          <el-switch
            v-model="value2"
            :width="50"
            @change="changeSwitch(value2)"
            active-color="#13ce66">
          </el-switch>
          <p style="color: #fff;margin: 5px;" v-if="value2">You are following</p>
          <p style="color: #fff;margin: 5px;" v-else>Not following</p>
        </el-col>
        <el-col :span="15" :xs="24" class="card_col right">
          <h2 class="title">INFOMATION</h2>
          <div class="follows">
            <p>followings</p>
          </div>
        </el-col>
      </el-row>
      <!-- <p v-for="u in user.followings" :key="u.name">{{ u.name }}</p>
      <h2>followers</h2>
      <p v-for="u in user.followers" :key="u.id">{{ u.name }}</p>
      <h2 @click="unFollow">unfollow</h2> -->
   </el-card>
  </el-main>
</template>

<script>
export default {
  async asyncData({ params, $axios }){
    let baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    let data = await $axios.$get(baseUrl + `/api/users/${params.id}`)
    console.log('asyncData')
    console.log(data)
    return {
      user: data,
      value2: false
    }
  },
  async mounted(){
    let res = await this.$axios.$get(process.env.browserBaseUrl + '/api/isFollowed', {
      params: {
        user_id: this.$store.state.auth.currentUser.id,
        follow_id: this.user.id
    }})
    this.value2 = Boolean(res)
  },
  methods: {
    follow(){
      this.$axios.$post(process.env.browserBaseUrl + '/api/relationships', {
          user_id: this.$store.state.auth.currentUser.id,
          follow_id: this.user.id
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
          follow_id: this.user.id
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
  }
}
</script>

<style>
.user_show_wrapper {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.user_show_wrapper .card {
  padding: 0;
  width: 600px;
  border-radius: 20px;
}
.user_show_wrapper .el-card__body {
  padding: 0;
  width: 600px;
  border-radius: 20px;
}
.user_show_wrapper .card_col {
  padding: 30px;
  height: 500px;
}
.user_show_wrapper .left {
  /* background: linear-gradient(to right,#87ac01,#bedf01); */
  background: linear-gradient(to right,#01a9ac,#01dbdf);
  text-align: center;
}
.user_show_wrapper .title {
  margin-bottom: 15px;
  padding-bottom: 5px;
  border-bottom: 1px solid #e0e0e0;
  color: #353c4e;
  letter-spacing: 5px;
}
.user_show_wrapper .follows {
  background: #ccc;
}
</style>