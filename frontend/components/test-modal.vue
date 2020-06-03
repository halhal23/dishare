<template>
  <el-dialog 
    class="login" 
    :center="true" 
    title="ログイン" 
    :visible.sync="$props.testModal" 
    :before-close="onModal" 
    
    >
    <el-form>
      <el-form-item label="名前" :label-width="formLabelWidth">
        <el-input v-model="name" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="メールアドレス" :label-width="formLabelWidth">
        <el-input v-model="email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="パスワード" :label-width="formLabelWidth">
        <el-input v-model="password" show-password></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="primary">キャンセル</el-button>
      <el-button type="primary">ログイン</el-button>
    </span>
  </el-dialog>
  <!-- <el-dialog 
    title="Shipping address" 
    :visible.sync="$props.testModal"
    :before-close="onModal"
    >
    <h1>成功だ！喜べ！</h1>
  </el-dialog> -->
</template>

<script>
export default {
  props: {
    'testModal': Boolean
  },
  data(){
    return {
      name: '',
      email: '',
      password: '',
      formLabelWidth: '120px'
    }
  },
  methods: {
    onModal(){
      this.$emit('onModal')
    }
  }
}
</script>

<style>
.login .el-dialog {
  height: 400px;
}
</style>
