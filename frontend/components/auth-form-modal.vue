<template> <!-- ログインとサインアップの共通のModalコンポーネント -->
  <el-dialog 
    class="auth" 
    :center="true" 
    :title="title" 
    :visible.sync="$props.testModal" 
    :before-close="onModal" 
    >
    <el-form>
      <el-form-item label="name" :label-width="formLabelWidth">
        <el-input v-model="form.name" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="email" :label-width="formLabelWidth" v-if="!$props.isLogin">
        <el-input v-model="form.email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="password" :label-width="formLabelWidth">
        <el-input v-model="form.password" show-password></el-input>
      </el-form-item>
      <el-form-item v-if="!$props.isLogin" label="password(confirm)" :label-width="formLabelWidth">
        <el-input v-model="form.password_confirmation" show-password></el-input>
      </el-form-item>
      <el-form-item label="icon" :label-width="formLabelWidth" v-if="!$props.isLogin">
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
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="onModal" class="authButton" round>Cancel</el-button>
      <el-button @click="testSignIn" type="primary" class="authButton" plain round>Login by test user</el-button>
      <el-button v-if="$props.isLogin" @click="doLogin" type="primary" class="authButton" round>Login</el-button>
      <el-button v-else @click="doSignUp" type="primary" class="authButton" round>SignUp</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  props: {
    'testModal': Boolean,
    'isLogin': Boolean
  },
  data(){
    return {
      form: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        imageFile: '',
      }, 
      formLabelWidth: '120px',
      fileList: [],
      active: 0
    }
  },
  computed: {
    title(){
      return this.isLogin ? "Login" : "SignUp"
    }
  },
  methods: {
    onModal(){
      this.$emit('onModal')
    },
    async doLogin(){
      const result = await this.login(this.form)
      console.log(result)
      this.onModal() // Modalを閉じる
    },
    doSignUp(){
      this.signUp(this.form)
      this.onModal() // Modalを閉じる
      this.$notify({
        title: 'SignUp successfully',
        message: 'Welcome to dishare!!',
        type: 'success'
      });
    },
    testSignIn(){
      this.formData = {
        name: "test",
        email: "test@gmail.com",
        password: "password",
        password_confirmation: "password"
      }
      this.login(this.formData)
      this.onModal()
      this.$notify({
        title: 'Login successfully',
        message: 'Welcome to dishare!!',
        type: 'success'
      });
    },
    ...mapActions({
      login: 'auth/login',
      logout: 'auth/logout',
      signUp: 'auth/signUp',
    }),
    handleAdd: function (file, fileList) {
      if (fileList.length === 2){
        fileList.shift()
      }
      this.fileList = fileList
      this.form.imageFile = fileList[0].raw
    },
    handleRemove(file, fileList) {
        console.log('remove');
        this.fileList = []
        this.form.imageFile = ''
    },
    handlePreview(file) {
        console.log('Preview')
    }
  }
}
</script>

<style>
.auth .el-form-item__label {
  font-size: 12px;
}
@media screen and (max-width: 768px) {
  .authButton {
    font-size: 11px;
  }
}
</style>
