import React from 'react'

import { Link, Button } from './components'
import { Checkmark, Cross } from './components/icons'

export default ({ link, onSave, onRemove }) => (
  <div>
    <Link href={link.href} external>
      {link.text}
    </Link>

    <Button small onClick={onSave}>
      <Checkmark />
    </Button>
    <Button small onClick={onRemove}>
      <Cross />
    </Button>
  </div>
)
