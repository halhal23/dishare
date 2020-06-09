<template>
  <el-main class="main_form">
    <el-card class="sign_up_card">
      <h2>Sign UP</h2>
      <el-form>
        <el-form-item label="名前" :label-width="formLabelWidth">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="メールアドレス" :label-width="formLabelWidth">
          <el-input v-model="form.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="パスワード" :label-width="formLabelWidth">
          <el-input v-model="form.password" show-password></el-input>
        </el-form-item>
        <el-form-item label="パスワード(確認用)" :label-width="formLabelWidth">
          <el-input v-model="form.password_confirmation" show-password></el-input>
        </el-form-item>
        <el-form-item label="icon" :label-width="formLabelWidth">
          <el-upload
            class="upload-demo"
            action="#"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :file-list="fileList"
            :on-change="handleAdd"
            list-type="picture">
            <el-button size="small" type="primary" style="margin-right: 30px;">Click to upload</el-button>
            <span slot="tip" class="el-upload__tip">jpg/png  </span>
          </el-upload>
        </el-form-item>
        <el-form-item>
          <el-button @click="signUp(form)" size="small" type="primary">SUBMIT</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </el-main>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data(){
    return {
      form: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        imageFile: '',
      },
      fileList: [{
          name: 'default icon', 
          url:  'images/no-image.png'
        }],
      formLabelWidth: '150px'
    }
  },
  methods: {
    ...mapActions({
      signUp: 'auth/signUp',
    }),
    handleAdd: function (file, fileList) {
      if (fileList.length === 2){
        fileList.shift()
        console.log('if handle add')
      }
      console.log('handleadd')
      this.fileList = fileList
      this.form.imageFile = fileList[0].raw
      console.log(this.form.imageFile)
    },
    handleRemove(file, fileList) {
        console.log(file, fileList);
    },
    handlePreview(file) {
        console.log('file')
        console.log(file);
        this.image = file.raw
    },
  }
}
</script>

<style>
.main_form {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.sign_up_card {
  width: 500px;
  height: 550px;
  text-align: center;
}
</style>