import React from 'react'

import { Link, Button } from './components'
import { Cross } from './components/icons'

export default ({ item, id, onRemove }) => (
  <div>
    <Link href={item.href} external>
      {item.text}
    </Link>
    <Button onClick={() => onRemove(id)}>
      <Cross />
    </Button>
  </div>
)
