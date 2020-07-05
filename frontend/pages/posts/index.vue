<template>
  <el-main class="posts_index_wrapper">
    <div class="posts">
      <el-tabs v-model="tabActive" @tab-click="handleSelectUsers">
        <el-tab-pane label="Followings" name="first">
          <div class="posts_container">
          <el-timeline>
            <el-timeline-item :timestamp="sliceCreatedAt(p.created_at)" placement="top" v-for="p in followingPosts" :key="p.id">
              <postCard :post="p" @getUpdatePosts="getUpdatePosts" />
            </el-timeline-item>
          </el-timeline>
          </div>
        </el-tab-pane>
        <el-tab-pane label="Followers" name="second">
          <div class="posts_container">
            <el-timeline>
              <el-timeline-item :timestamp="sliceCreatedAt(p.created_at)" placement="top" v-for="p in followerPosts" :key="p.id">
                <postCard :post="p" @getUpdatePosts="getUpdatePosts" />
              </el-timeline-item>
            </el-timeline>
          </div>
        </el-tab-pane>
        <el-tab-pane label="All posts" name="third">
          <div class="posts_container">
            <el-timeline>
              <el-timeline-item :timestamp="sliceCreatedAt(p.created_at)" placement="top" v-for="p in allPosts" :key="p.id">
                <postCard :post="p" @getUpdatePosts="getUpdatePosts" />
              </el-timeline-item>
            </el-timeline>
          </div>
        </el-tab-pane>
        <el-tab-pane label="Searched postss" name="fourth" v-if="searchedPosts.length > 0">
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
      searchedPosts: [],
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
    },
    search(){
      this.searchedPosts = [1]
      this.tabActive = "fourth"
    },
    handleOpen(key, keyPath) {
      console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    },
    sliceCreatedAt(str){
      return str.substr(0, 10) + "  " + str.substr(11, 8)
    },
  },
  components: {
    postCard
  }
}
</script>

<style>
.posts_index_wrapper {
  height: 100vh;
  padding: 60px 100px 0;
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
  background: #d8b390;
}
.posts_index_wrapper .el-tabs__content {
  background: #d8b390;
  height: 80vh;
}
.posts_index_wrapper .el-tabs__header {
  background: #d8b390;
  padding: 20px;
  margin: 0;
}
.posts_index_wrapper .posts_container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}
.posts_index_wrapper ul.el-timeline {
  padding: 0;
}
.posts_index_wrapper .el-timeline-item__timestamp {
  color: #fff;
}
.posts_index_wrapper .el-timeline-item__timestamp {
  color: #fff;
}
.posts_index_wrapper .pagenation {
  background: #ccc;
  width: 500px;
  margin: 10px auto;
}
@media (min-width: 0px) and (max-width: 768px) {
  .posts_index_wrapper {
    padding: 70px 0;
  }
  .posts_index_wrapper .el-tabs__content {
    height: 72vh;
  }
  .posts_index_wrapper ul.el-timeline {
    padding: 0;
    width: 100%;
  }
}
</style>