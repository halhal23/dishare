<template>
  <el-main>
    <h2>sdsdfsdf</h2>
    <h2>sdsdfsdf</h2>
    <h2>sdsdfsdf</h2>
    <h2>sdsdfsdf</h2>
    <h2 @click="follow">{{ user.name }} dfsfsdfsdfsdfsfsdfsdfsdfdsdfsd</h2>
    <h2>sdsdfsdf</h2>
    <h2>sdsdfsdf</h2>
    <div style="padding: 20px 100px;">
      <h2>followings</h2>
      <p v-for="u in user.followings" :key="u.name">{{ u.name }}</p>
      <h2>followers</h2>
      <p v-for="u in user.followers" :key="u.id">{{ u.name }}</p>
      <h2 @click="unFollow">unfollow</h2>
    </div>
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
      user: data
    }
  },
  mounted(){
    console.log(this.user)
  },
  methods: {
    follow(){
      this.$axios.$post(process.env.browserBaseUrl + '/api/relationships', {
           user_id: this.$store.state.auth.currentUser.id,
           follow_id: this.user.id
      }).then(res => {
        this.user = res
        console.log('follow 成功')
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
      })
    },
    test(){
      console.log(this.$store.state.auth.currentUser.id)
      this.$axios.$get(process.env.browserBaseUrl + '/api/test',{
        params: {
          user_id: this.$store.state.auth.currentUser.id
        }
      }).then(res => {
        console.log(res)
      })
    }
  }
}
</script>