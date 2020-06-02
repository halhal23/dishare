<template>
  <el-dialog 
    title="Shipping address" 
    :visible.sync="$props.testModal"
    :before-close="onModal"
    >
    <h1>成功だ！喜べ！</h1>
  </el-dialog>
</template>

<script>
export default {
  props: {
    'testModal': Boolean
  },
  methods: {
    onModal(){
      this.$emit('onModal')
    }
  }
}
</script>
