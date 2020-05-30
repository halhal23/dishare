<template>
<div style="margin-top: 70px;">
  <h1>posts</h1>
  <h1>posts</h1>
  <h1>posts</h1>
  <el-button @click="getUser" style="margin: 20px;">user show</el-button>
</div>
</template>

<script>
export default {
  methods: {
    getUser(){
      this.$axios.$get(process.env.browserBaseUrl + '/users/show', {
        params: {user_id: 1}
      }).then(res => {
        console.log(res)
      }).catch(err => {
        console.log(err)
      })
    }
  }
}
</script>