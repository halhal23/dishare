<template>
  <el-main class="users_index_wrapper">
      <el-tabs @tab-click="doClick" tab-position="top" :stretch="true">
        <el-tab-pane label="followings"></el-tab-pane>
        <el-tab-pane label="followers"></el-tab-pane>
        <el-tab-pane label="All Users"></el-tab-pane>
      </el-tabs>
      <div class="users_container">
        <el-card v-for="u in users" :key="u.id">
          <nuxt-link :to="{ path: `/users/${u.id}`}">
            <el-avatar :src="u.image.url" :size="40"></el-avatar>
            <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">{{ u.name }}</p>
            <p style="font-size: 12px;">since: {{ u.created_at.substr(0, 10) }}</p>
          </nuxt-link>
        </el-card>
      </div>
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
      console.log('tab users')
      console.log(data)
    }
  }
}
</script>

<style>
.users_index_wrapper {
  padding: 70px;
  height: 100vh;
}
.users_index_wrapper .el-tabs__item {
  font-family: cursive;
  font-size: 24px;
}
.users_index_wrapper .el-tabs__content {
  height: 0;
}
.users_container {
  height: 90%;
  display: flex;
  flex-wrap: wrap;
  overflow-y: scroll;
  justify-content: space-around;
  align-content: flex-start;
}

.users_container .el-card{
  width: 400px;
  height: 60px;
  flex-shrink: 0;
  margin: 10px 20px;
}
.users_container .el-card__body{
  padding: 0;
}
.users_container .el-card.is-always-shadow:hover{
  box-shadow: 0 0 20px black;
}
.users_container .el-card__body a{
  display: flex;
  align-items: center;
  color: #555;
  padding: 10px 20px;
}
@media (min-width: 0px) and (max-width: 768px) {
  .users_index_wrapper {
    padding: 70px 10px;
  }
}
</style>