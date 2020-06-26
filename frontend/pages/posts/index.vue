<template>
  <el-main class="posts_index_wrapper">
    <el-menu
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
    </el-menu>

    <div class="posts">
      <postCard v-for="p in posts" :key="p.id" :post="p" @getUpdatePosts="getUpdatePosts" />
    </div>
    <nuxt-link :to="{ path: '/posts/new'}" class="flex-center new_post_icon">
      <i class="el-icon-plus"></i>
    </nuxt-link>
  </el-main>
</template>

<script>
import postCard from '~/components/post-card.vue'
export default {
  // フォローしているユーザの記事のみを取得
  async asyncData({ $axios, params, store}){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const data = await $axios.$get(baseUrl + '/api/posts/following_posts', {
      params: { user_id: store.state.auth.currentUser.id }
    })   
    return {
      posts: data,
    }
  },
  methods: {
    async handleSelectUsers(key, keyPath) {
      if(key == 1){
        const data = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts/following_posts', {
          params: { user_id: this.$store.state.auth.currentUser.id }
        })         
        this.posts = data  
      } else if (key == 2){
        const data = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts/follower_posts', {
          params: { user_id: this.$store.state.auth.currentUser.id }
        }) 
        this.posts = data      
      } else if (key == 3){
        const data = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts')
        this.posts = data
      }
    },
    async getUpdatePosts(){
      const data = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts', {
        params: { user_id: this.$store.state.auth.currentUser.id }
      })
      this.posts = data
    }
  },
  components: {
    postCard
  }
}
</script>

<style>
.posts_index_wrapper {
  height: 100vh;
  padding: 60px 60px 0;
  background: rgb(255, 209, 81);
}
.new_post_icon {
  background: tomato;
  width: 50px;
  height: 50px;
  color: #fff;
  border-radius: 25px;
  box-shadow: 0 0 10px #ccc;
  position: fixed;
  bottom: 70px;
  right: 30px;
  z-index: 5;
}
.posts_index_wrapper .posts {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: flex-start;
  height: 90%;
  padding: 30px 0;
  overflow-y: scroll;
  background: rgba(189, 187, 181, 0.281);
}
@media (min-width: 0px) and (max-width: 768px) {
  .posts_index_wrapper {
    padding: 70px 0;
  }
}
</style>