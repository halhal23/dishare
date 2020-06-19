<template>
  <el-main class="main-posts-index">
    <!-- <div style="height: 100%;">
      <el-tabs @tab-click="doClick" tab-position="top" :stretch="true" style="height: 100%;">
        <el-tab-pane label="All Users">User</el-tab-pane>
        <el-tab-pane label="Your friends" style="height: 100%;"> -->
          <div class="posts_wrapper">
            <postCard v-for="p in posts" :key="p.id" :post="p" @getUpdatePosts="getUpdatePosts" />
          </div>
        <!-- </el-tab-pane>
      </el-tabs>
    </div> -->
  </el-main>
</template>

<script>
import postCard from '~/components/post-card.vue'
export default {
  async asyncData({ $axios, params}){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const data = await $axios.$get(baseUrl + '/api/posts')
    console.log(data)
    return {
      posts: data,
      visible: false
    }
  },
  methods: {
    getPost(){
      console.log('getPost')
      this.$axios.$get(process.env.apiBaseUrl + '/api/posts').then(res => {
        console.log(res)
      }).catch(err => {
        console.log(err)
      })
    },
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
  height: 100%;
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