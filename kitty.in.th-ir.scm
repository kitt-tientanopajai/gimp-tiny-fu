;; kitty.in.th-auto-levels.scm
;; v. 0.12
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2008 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script creates a infrared-like effect.
;;
;; ChangeLogs
;; v0.12 - Mon, 15 Dec 2008 22:40:12 +0700
;; - Move to Filters menu
;;
;; v0.11 - Wed, 19 Nov 2008 01:09:37 +0700
;; - Scheme coding style
;;
;; v0.10 - Wed, 14 May 2008 23:42:22 +0700
;; - Fix blur layer is not grayscale
;; - Tiny-Fu revisited
;;
;; v0.09 - Sat, 24 Nov 2007 00:51:38 +0700
;; - Fixed blur layer

(define (kitty.in.th-add-blur-layer image layer radius)
	(let * (
		(blur-layer (car (gimp-layer-new-from-drawable layer image))))

		(gimp-layer-set-name blur-layer "kitty.in.th - ir blur")
		(gimp-image-add-layer image blur-layer -1)
		(gimp-layer-set-mode blur-layer SCREEN)
		(plug-in-gauss-iir2 1 image blur-layer radius radius)))

(define (kitty.in.th-ir image drawable radius)
	(gimp-image-undo-group-start image)
	(let* (
		(grayscale-layer (car (gimp-layer-new-from-drawable drawable image))))


		(gimp-layer-set-name grayscale-layer "kitty.in.th - grayscale")
		(gimp-image-add-layer image grayscale-layer -1)
		(plug-in-colors-channel-mixer 1 image grayscale-layer TRUE 0.3 0.59 0.11 0.3 0.59 0.11 0.3 0.59 0.11)
		
		(kitty.in.th-add-blur-layer image grayscale-layer radius)

		(gimp-levels-stretch grayscale-layer)
		(gimp-levels grayscale-layer HISTOGRAM-VALUE 0 255 0.7 0 255)
		(gimp-hue-saturation grayscale-layer 0 0 0 -20))

	(gimp-image-undo-group-end image)
	(gimp-displays-flush))

(script-fu-register
	"kitty.in.th-ir"
	"<Image>/Filters/kitty.in.th/Infrared Filter..."
	"kitty.in.th infrared filter effect v.0.12"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-ADJUSTMENT "Blur radius" '(8 0 255 1 5 0 0))
