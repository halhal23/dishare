<template>
  <el-main class="posts_index_wrapper">
    <div class="posts">
      <el-tabs v-model="tabActive" @tab-click="handleSelectUsers">
        <el-tab-pane label="Followings" name="first">
          <div class="posts_container">
            <postCard v-for="p in followingPosts" :key="p.id" :post="p" @getUpdatePosts="getUpdatePosts" />
          </div>
        </el-tab-pane>
        <el-tab-pane label="Followers" name="second">
          <div class="posts_container">
            <postCard v-for="p in followerPosts" :key="p.id" :post="p" @getUpdatePosts="getUpdatePosts" />
          </div>
        </el-tab-pane>
        <el-tab-pane label="All posts" name="third">
          <div class="posts_container">
            <postCard v-for="p in allPosts" :key="p.id" :post="p" @getUpdatePosts="getUpdatePosts" />
          </div>
        </el-tab-pane>
      </el-tabs>
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
    const followingPosts = await $axios.$get(baseUrl + '/api/posts/following_posts', {
      params: { user_id: store.state.auth.currentUser.id } 
    }) 
    return {
      followingPosts: followingPosts,
      followerPosts: [],
      allPosts: [],
      tabActive: 'first'
    }
  },
  methods: {
    async handleSelectUsers(tab) {
      console.log(tab.label)
      switch (tab.label){
        case 'Followers':
          const follwerPosts = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts/follower_posts', {
            params: { user_id: this.$store.state.auth.currentUser.id }
          }) 
          this.followerPosts = follwerPosts 
          break
        case 'All posts':
          const allPosts = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts')
          this.allPosts = allPosts
          break   
      }
    },
    async getUpdatePosts(){
          const allPosts = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts')
          this.allPosts = allPosts
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
  padding: 0 10px 0;
  background: #f1decc;
}
.posts_index_wrapper .el-tabs__content {
  background: #f1decc;
  height: 80vh;
}
.posts_index_wrapper .el-tabs__header {
  background: #f1decc;
  padding: 20px;
  margin: 0;
}
.posts_index_wrapper .posts_container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}
@media (min-width: 0px) and (max-width: 768px) {
  .posts_index_wrapper {
    padding: 70px 0;
  }
  .posts_index_wrapper .el-tabs__content {
    height: 72vh;
  }
}
</style>