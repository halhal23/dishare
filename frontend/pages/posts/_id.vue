<template>
  <el-main class="post_detail_wrapper">
    <el-row class="container">
      <el-col :span="24" :sm="14">
        <div class="created flex-col-start">
          <p class="title">Posted at</p>
          <p class="flex-full-center">{{ sliceCreatedAt(post.created_at) }}</p>
        </div>
        <div class="content flex-col-start">
          <p class="title">Content</p>
          <p class="flex-full-center">{{ post.content }}</p>
        </div>
        <div class="photos flex-col-start">
          <p class="title">Photo</p>
          <div class="photos_wrapper">
            <el-carousel :interval="5000" arrow="always" height="250px" indicator-position="outside">
              <el-carousel-item v-if="post.shop_name">
                <el-image
                :src="post.shop_image_url"
                style="width: 100%;height: 100%;"
                fit="cover"></el-image>
              </el-carousel-item>
              <el-carousel-item v-if="post.shop_name">
                <div class="shop_detail" style="padding: 20px;text-align: center;">
                  <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_name }}</p>
                  <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_category }}</p>
                  <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_access }}</p>
                  <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_address }}</p>
                  <a class="shop_detail_item" :href="post.shop_url" style="padding: 0;" target="_blank">詳しくはこちら</a>
                </div>
              </el-carousel-item>
              <el-carousel-item v-for="photo in post.photos" :key="photo.id">
                <el-image
                  style="width: 100%; height: 100%"
                  :src="photo.picture.url"
                  fit="cover"></el-image>
              </el-carousel-item>
            </el-carousel>
          </div>
        </div>
        <div class="author flex-col-start">
          <p class="title">Post by</p>
          <div class="flex-full-center">
            <nuxt-link :to="{ path: `/users/${post.user.id}`}" style="width: 60px;height: 60px">
              <el-avatar shape="square" :size="60" :src="post.user.image.url"></el-avatar>
            </nuxt-link>

            <p style="margin-left: 50px;font-weight: bold;font-size: 24px;">
              <nuxt-link :to="{ path: `/users/${post.user.id}`}" style="color: black;">
                {{ post.user.name }}
              </nuxt-link>
            </p>

          </div>
        </div>
      </el-col>
      <el-col :span="24" :sm="10">
        <div class="comments flex-col-start">
          <p class="title">Comments</p>
          <div class="timeline_container">
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
          </div>
          <div class="comment_form_box flex-center">
              <el-input placeholder="Please input" v-model="message" class="input-with-select">
                <el-button @click="createComment" slot="append">Comment</el-button>
              </el-input>
          </div>
        </div>
      </el-col>
    </el-row>
  </el-main>
</template>

<script>
import postCard from '~/components/post-card.vue'
export default {
  async asyncData({ $axios, params }){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const data = await $axios.$get(baseUrl + `/api/posts/${params.id}`)
    return {
      post: data,
      message: '',
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
        this.message = ''
        this.post = res
      }).catch(err => {
        console.log(err)
      })
    },
    destroyComment(id){
      this.$axios.$delete(process.env.browserBaseUrl + `/api/comments/${id}`).then(res => {
        this.post = res
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
.post_detail_wrapper {
  height: 100vh;
  padding: 60px 0 0 60px;
}
.post_detail_wrapper .container{
  height: 100%;
  width: 100%;
}
.post_detail_wrapper .el-row,
.post_detail_wrapper .el-col{
  height: 100%;
}
.post_detail_wrapper .created {
  background:#ffe89d;
  height: 10%;
}
.post_detail_wrapper .comments {
  background:#ffe89d;
  height: 100%;
  position: relative;
}
.post_detail_wrapper .content {
  background:#ffe89d;
  height: 20%;
}
.post_detail_wrapper .photos {
  background:#ffe89d;
  height: 55%;
}  
.post_detail_wrapper .author {
  background:#ffe89d;
  height: 15%;
}
.post_detail_wrapper .title {
  color: #fff;
  background: rgb(207, 144, 102);
  font-weight: bold;
  width: 100%;
}
.post_detail_wrapper .comment_form_box {
  background: #666;
  position: absolute;
  bottom: 0;
  right: 0;
  width: 100%;
  padding: 20px;
}
.post_detail_wrapper .photos_wrapper {
  height: 100%;
  width: 100%; 
  padding: 40px 20px;
}
.post_detail_wrapper .timeline_container {
  padding: 30px 30px 100px 30px;
  overflow-y: scroll;
  height: 100%;
  width: 100%;
  background: #fff;
}
.post_detail_wrapper .timeline_container ul {
  padding: 0;
}

@media (min-width: 0px) and (max-width: 768px) {
  .post_detail_wrapper {
    padding: 80px 40px;
  }
  .post_detail_wrapper .photos_wrapper {
    padding: 5px;
  }
}
</style>