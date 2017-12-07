import React from 'react'
import styled from 'styled-components'

import { Input, Button } from './components'

const Form = styled.form`display: flex;`

class AddItem extends React.Component {
  state = {
    text: '',
    href: '',
  }

  onChange = ({ target }) => {
    this.setState({ [target.name]: target.value })
  }

  onSubmit = e => {
    e.preventDefault()

    if (this.state.href) {
      this.props.onAdd({
        text: this.state.text || this.state.href,
        href: this.state.href,
      })
      this.setState({ text: '', href: '' })
    }
  }

  render() {
    return (
      <Form onSubmit={this.onSubmit}>
        <div>
          <label htmlFor="text">Text</label>
          <Input name="text" value={this.state.text} onChange={this.onChange} />
        </div>
        <div>
          <label htmlFor="href">Link</label>
          <Input name="href" value={this.state.href} onChange={this.onChange} />
        </div>

        <Button onClick={this.onSubmit}>Add</Button>
      </Form>
    )
  }
}

export default AddItem
