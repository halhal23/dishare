<template>
  <el-main class="post_show_wrapper">
      <postCard :post="post"/>
      <div class="comments_wrapper">
        <el-timeline>
          <el-timeline-item :timestamp="sliceCreatedAt(c.created_at)" placement="top" v-for="c in post.comments" :key="c.id">
            <el-card>
              <h4 style="margin-bottom: 20px;">{{ c.message }}</h4>
              <p style="display: flex; align-items: center;">
                <el-avatar style="margin-right: 20px;" :size="30" :src="c.user.image.url"></el-avatar>
                <span style="margin-right: 20px;">{{ c.user.name }}</span>
                <el-button v-if="c.user.id == $store.state.auth.currentUser.id" @click="destroyComment(c.id)" type="danger" size="mini" icon="el-icon-delete" circle></el-button>
              </p>
            </el-card>
          </el-timeline-item>
        </el-timeline>
        <el-input type="textarea" :rows="2" v-model="message"></el-input>
        <el-button @click="createComment" type="primary" style="margin-top: 10px;">Comment</el-button>
      </div>
  </el-main>
</template>

<script>
import postCard from '~/components/post-card.vue'
export default {
  async asyncData({ $axios, params }){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const data = await $axios.$get(baseUrl + `/api/posts/${params.id}`)
    return {
      post: data
    }
  },
  data(){
    return {
      message: ''
    }
  },
  methods: {
    // コメントの日付のフォーマットを整形。
    sliceCreatedAt(str){
      return str.substr(0, 10) + "  " + str.substr(11, 8)
    },
    createComment() {
      const formData = {
        message: this.message,
        user_id: this.$store.state.auth.currentUser.id,
        post_id: this.post.id
      }
      this.$axios.$post(process.env.browserBaseUrl + `/api/comments`, formData).then(res => {
        console.log('res')
        this.post = res
      }).catch(err => {
        console.log(err)
      })
    },
    destroyComment(id){
      this.$axios.$delete(process.env.browserBaseUrl + `/api/comments/${id}`).then(res => {
        this.post = res
        this.$router.push(`/posts/${this.post.id}`)
      }).catch(err => {
        console.log(err)
      })
    }
  },
  components: {
    postCard
  }
}
</script>

<style>
.post_show_wrapper {
  padding: 70px 0;
  display: flex;
  justify-content: space-around;
  align-items: flex-start;
  flex-wrap: wrap;
}
.post_show_wrapper ul {
  padding: 0;
}
/* .post_show_wrapper .el-card__body {
  padding: 10px;
} */
@media (min-width: 0px) and (max-width: 768px) {
  .comments_wrapper {
    width: 95%;
    flex-shrink: 0;
  }
}
</style>