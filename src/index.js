import React from 'react'
import { render } from 'react-dom'
import { injectGlobal } from 'styled-components'

import App from './App'

injectGlobal`
  body {
    font-family: Helvetica;
    margin: 0;
    padding: 0;
  }

  body * {
    box-sizing: border-box;
  }
`
render(<App />, document.getElementById('root'))
