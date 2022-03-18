import MerkleTree from './merkle-tree'
import { utils } from 'ethers'

export interface Token { 
	creator: string;
	uri: string
}

export default class TokenTree {
	private readonly tree: MerkleTree
	constructor(tokens: Token[]) {
		this.tree = new MerkleTree(
			tokens.map((token, index) => {
				return TokenTree.toNode(token)
			})
		)
	}

	public static verifyProof(
		token: Token,
		proof: Buffer[],
		root: Buffer
	): boolean {
		let pair = TokenTree.toNode(token)
		for (const item of proof) {
			pair = MerkleTree.combinedHash(pair, item)
		}

		return pair.equals(root)
	}

	public static toNode(token: Token): Buffer {
		return Buffer.from(
			utils.solidityKeccak256(['address','string'], [token.creator, token.uri]).substring(2),
			'hex'
		)
	}

	public getHexRoot(): string {
		return this.tree.getHexRoot()
	}

	// returns the hex bytes32 values of the proof
	public getProof(token: Token): string[] {
		return this.tree.getHexProof(TokenTree.toNode(token))
	}
}
