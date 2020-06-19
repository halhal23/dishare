<template>
  <el-main class="new_post_wrapper">
    <el-form>
      <h2>New Post</h2>
      <h4>message</h4>
      <el-input v-model="message" type="textarea"></el-input>
      <el-upload
        class="upload-demo"
        drag
        action="#"
        :on-preview="handlePreview"
        :on-remove="handleRemove"
        :file-list="fileList"
        list-type="picture"
        :limit="4"
        multiple>
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">Drop file here or <em>click to upload</em></div>
        <div class="el-upload__tip" slot="tip">jpg/png files with a size less than 500kb</div>
      </el-upload>
      <el-button type="success" plain round>Submit</el-button>
    </el-form>
  </el-main>
</template>

<script>
import uploadForm from '~/components/upload-form.vue'
export default {
  data(){
    return {
      message: '',
      fileList: []
    }
  },
  methods: {
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
}
</style>