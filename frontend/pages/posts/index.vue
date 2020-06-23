<template>
  <el-main class="main-posts-index">
      <div class="posts_wrapper">
        <postCard v-for="p in posts" :key="p.id" :post="p" @getUpdatePosts="getUpdatePosts" />
        <div v-if="posts.length == 0" style="text-align: center;">
          <h2 style="font-family:  Times, 'Times New Roman', serif;">Lets follow other users and see what they post!</h2>
          <nuxt-link to="/users">
            <el-button style="margin: 30px auto;">
              See users
            </el-button>
          </nuxt-link>
        </div>
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
    const data = await $axios.$get(baseUrl + '/api/posts', {
      params: { user_id: store.state.auth.currentUser.id }
    })
    return {
      posts: data,
      visible: false
    }
  },
  methods: {
    redirectPost(id){
      this.$router.push(`/posts/${id}`)
    },
    doClick(tab){
      console.log(tab.label);
    },
    async getUpdatePosts(){
      const data = await this.$axios.$get(process.env.browserBaseUrl + '/api/posts')
      this.posts = data
    }
  },
  components: {
    postCard
  }
}
</script>

<style>
.main-posts-index {
  padding: 70px 60px 60px;
  height: 100vh;
  position: relative;
}
.main-posts-index .el-tabs__item {
  font-family: cursive;
  font-size: 30px;
}
.main-posts-index .el-tabs__content {
  height: 90%;
}
.main-posts-index .posts_wrapper {
  display: flex;
  justify-content: space-around;
  align-items: flex-start;
  flex-wrap: wrap;
}
.post_card {
  box-shadow: 0 0 20px gray;
  width: 500px;
  margin: 20px;
  flex-shrink: 0;
}
.post_card .el-col {
  height: 100
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
@media (min-width: 0px) and (max-width: 768px) {
  .post_card {
    width: 95%;
  }
  .main-posts-index {
    padding: 70px 10px;
  }
}
</style>