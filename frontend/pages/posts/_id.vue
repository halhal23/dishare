<template>
  <el-main class="post_show_wrapper">
      <div>
        <postCard :post="post"/>
      </div>
      <div class="comments_wrapper">
        <el-timeline>
          <el-timeline-item :timestamp="c.created_at" placement="top" v-for="c in post.comments" :key="c.id">
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
  async asyncData(app){
    let data;
    if (process.client){
      data =  await app.$axios.$get(process.env.browserBaseUrl + `/api/posts/${app.params.id}`)
      console.log('asyncData client side')
      console.log(data)
    } else {
      data =  await app.$axios.$get(process.env.apiBaseUrl + `/api/posts/${app.params.id}`)
      console.log('asyncData server side')
      console.log(data)
    }
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
    test(){
      console.log(this.$store.state.auth.currentUser.id)
    },
    createComment() {
      const formData = {
        message: this.message,
        user_id: this.$store.state.auth.currentUser.id,
        post_id: this.post.id
      }
      this.$axios.$post(process.env.browserBaseUrl + `/api/comments`, formData).then(res => {
        console.log('res')
        console.log(res)
        this.post = res
      }).catch(err => {
        console.log(err)
      })
    },
    destroyComment(id){
      this.$axios.$delete(process.env.browserBaseUrl + `/api/comments/${id}`).then(res => {
        console.log(res)
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
  padding-top: 70px;
  display: flex;
  justify-content: space-around;
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