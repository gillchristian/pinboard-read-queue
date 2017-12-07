import React from 'react'
import styled from 'styled-components'
import { append } from 'sanctuary'

import { storage } from './services'
import { remove } from './utilities'

import { Row, Col } from './components'

import AddItem from './AddItem'
import NextItem from './NextItem'
import ListItem from './ListItem'

const Container = styled.div`padding: 10px;`

const STATE_KEY = 'checkout-queue-state'

export default class App extends React.Component {
  state = storage(STATE_KEY) || {
    queue: [],
    resources: [],
  }

  addItem = item => {
    this.setState(
      s => ({ queue: append(item, s.queue) }),
      () => storage(STATE_KEY, this.state),
    )
  }

  persistFirst = () => {
    this.setState(
      s => ({
        queue: remove(0, s.queue),
        resources: append(s.queue[0], s.resources),
      }),
      () => storage(STATE_KEY, this.state),
    )
  }

  removeQueueHead = () => {
    this.setState(
      s => ({
        queue: remove(0, s.queue),
      }),
      () => storage(STATE_KEY, this.state),
    )
  }

  removeResourcesItem = index => {
    this.setState(
      s => ({
        resources: remove(index, this.state.resources),
      }),
      () => storage(STATE_KEY, this.state),
    )
  }

  render() {
    return (
      <Container>
        <h1>Checkout queue</h1>

        <AddItem onAdd={this.addItem} />

        <Row>
          <Col width="40%">
            <h2>Next</h2>
            {this.state.queue[0] && (
              <NextItem
                onSave={this.persistFirst}
                onRemove={this.removeQueueHead}
                link={this.state.queue[0]}
              />
            )}
          </Col>

          <Col width="40%">
            <h2 key="title">Checked</h2>
            {this.state.resources.map((item, index) => (
              <ListItem
                key={`${index}-${item.text}`}
                id={index}
                item={item}
                onRemove={this.removeResourcesItem}
              />
            ))}
          </Col>
        </Row>
      </Container>
    )
  }
}
