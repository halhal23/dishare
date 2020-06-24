<template>
  <el-main>
  </el-main>
</template>

<script>
export default {
  async asyncData({ $axios, store }){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const data = await $axios.$get(baseUrl + `/api/users/${store.state.auth.currentUser.id}`)
    return {
      users: data.followings,
    }
  },
  methods: {
    async doClick(tab){
      let data
      if(tab.label === "All Users"){
        data = await this.$axios.$get(process.env.browserBaseUrl + '/api/users')
        this.users = data
      }else if (tab.label === "followings"){
        data = await this.$axios.$get(process.env.browserBaseUrl + `/api/users/${this.$store.state.auth.currentUser.id}`)
        this.users = data.followings
      }else{
        data = await this.$axios.$get(process.env.browserBaseUrl + `/api/users/${this.$store.state.auth.currentUser.id}`)
        this.users = data.followers   
      }
    }
  }
}
</script>

<style>
</style>