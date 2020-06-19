<template>
  <el-main class="new_post_wrapper">
    <h2 style="margin: 30px 0;font-size: 34px;">New Post</h2>
    <el-form>
      <el-divider>content</el-divider>
      <el-input v-model="form.content" type="textarea"></el-input>
      <el-divider>Photograshs</el-divider>
      <el-upload
        class="upload-demo"
        drag
        action="#"
        :on-preview="handlePreview"
        :on-remove="handleRemove"
        :file-list="fileList"
      
        :on-success="handleAdd"
        list-type="picture"
        :limit="4"
        multiple>
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">Drop file here or <em>click to upload</em></div>
        <div class="el-upload__tip" style="text-align: center;" slot="tip">You can post up to 4 images.</div>
      </el-upload>
      <el-divider><i class="el-icon-star-on"></i></el-divider>
      <el-button type="success" @click="postsCreate" style="margin: 10px auto;display: block;" plain round>Submit</el-button>
    </el-form>
  </el-main>
</template>

<script>
import uploadForm from '~/components/upload-form.vue'
export default {
  data(){
    return {
      form: {
        content: '',
        imageFiles: []
      },
      fileList: []
    }
  },
  methods: {
    postsCreate(){
      let formData = new FormData()
      formData.append("content", this.form.content)
      formData.append("user_id", this.$store.state.auth.currentUser.id)
      if (this.form.imageFiles.length > 0){
        this.form.imageFiles.forEach( f => {
          formData.append("picture" + '[]', f)
        })
      }
      this.$axios.$post(process.env.browserBaseUrl + '/api/posts', formData, {
        headers: {
            "Content-Type": "multipart/form-data"
        }
      }).then(res => {
        console.log('create post 成功')
        console.log(res)
        this.$router.push('/posts')
      }).catch(err => {
        console.log(err)
      })
    },
    handleAdd(status, file, fileList){
      this.form.imageFiles.push(file.raw)
      console.log(file)
      console.log('handleAdd')
      console.log(this.form.imageFiles)
      console.log(typeof this.form.imageFiles)
    },
    handlePreview(){
      console.log('preview')
    },
    handleRemove(){
      console.log('remove')
    },
  }
}
</script>

<style>
.new_post_wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  flex-direction: column;
  padding: 70px 0
}
.el-form {
  box-shadow: 0 0 18px #ccc;
  padding: 20px 10px;
}
</style>