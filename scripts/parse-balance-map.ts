import TokenTree, { Token } from './token-tree'
type Format = {creator:string,uri:string}[]

type NewFormat = {
	uri:string
	creator: string
	proofs: string[]
}

interface MerkleInfo {
	merkleRoot: string
	total: number
	tokens: NewFormat[]
}

export function parseTokenMap(tokens: Format): MerkleInfo {
	// construct a tree
	const tree = new TokenTree(tokens)
	const newTokens = tokens.map((token:Token, index)=>{
		return { 
			uri: token.uri,
			creator: token.creator,
			proofs: tree.getProof(token)
		}
	})
	return {
		merkleRoot: tree.getHexRoot(),
		total: tokens.length,
		tokens: newTokens,
	}
}
